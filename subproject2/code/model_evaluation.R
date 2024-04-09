pacman::p_load(
  dplyr,
  caret,
  ggplot2,
  lattice,
  knitr,
  broom,
  pROC
)
here::i_am(
  "subproject2/code/model_evaluation.R"
)

data_clean<-readRDS(
  here::here("data/data_clean.rds")
)

# logistic regression
# PREGNANT PNEUMONIA COPD DIABETES CARDIOVASCULAR RENAL_CHRONIC SEX AGE CLASSIFIED DIED as predictive variables
new_df <- data_clean %>%
  select(PREGNANT, PNEUMONIA, COPD, DIABETES, CARDIOVASCULAR, RENAL_CHRONIC,SEX, AGE, CLASSIFIED, DIED, ICU)
new_df<-na.omit(new_df)

model <- glm(ICU ~ PREGNANT + PNEUMONIA + COPD + DIABETES + CARDIOVASCULAR + RENAL_CHRONIC + SEX + AGE + DIED, 
             data = new_df, 
             family = binomial)


# Model Summary
tidy_model <- tidy(model)
model_table <- kable(tidy_model, caption = "Table. Model Summary", digits = 4)

saveRDS(
  model_table,
  file = here::here("subproject2/output/model/model_table.rds")
)

# Model Diagnostics
qqplot_path <- here::here("subproject2/output/model", "QQplot.png")
png(qqplot_path, width = 1600, height = 1200)
par(mfrow = c(2, 2))
plot(model)
dev.off()

# Making Predictions
new_df$predicted_probabilities <- predict(model, type = "response")
new_df$predicted_ICU_class <- ifelse(new_df$predicted_probabilities > 0.5, 1, 0)

# Confusion Matrix
confusion_matrix <- table(Predicted = new_df$predicted_ICU_class, Actual = new_df$ICU)
confusion_matrix<-kable(confusion_matrix,caption = "Confusion matrix")

saveRDS(
  confusion_matrix,
  file = here::here("subproject2/output/model/confusion_matrix.rds")
)

# upsampling
# Split the dataset into majority and minority classes
df_majority <- new_df %>% filter(ICU == 0)
df_minority <- new_df %>% filter(ICU == 1)

# Calculate how many times the minority class needs to be replicated
upsample_factor <- nrow(df_majority) / nrow(df_minority)

# Upsample the minority class
df_minority_upsampled <- df_minority %>% 
  slice(rep(1:n(), each = ceiling(upsample_factor))) %>%
  head(nrow(df_majority))  # Ensure equal size

# Combine the upsampled minority class with the original majority class
df_balanced <- bind_rows(df_majority, df_minority_upsampled)

# Shuffle the combined dataset to randomize the order of rows
set.seed(123)  # For reproducibility
df_balanced <- df_balanced[sample(nrow(df_balanced)), ]

# logistic regression
model_upsampled <- glm(ICU ~ PREGNANT + PNEUMONIA + COPD + DIABETES + CARDIOVASCULAR + RENAL_CHRONIC + SEX + AGE + CLASSIFIED + DIED, 
                       data = df_balanced, 
                       family = binomial)


# Model Summary
tidy_model <- tidy(model_upsampled)
model_upsampled_table <- kable(tidy_model, caption = "Table. Model_upsampled Summary", digits = 4)

saveRDS(
  model_upsampled_table,
  file = here::here("subproject2/output/model/model_upsampled_table.rds")
)

# Model Diagnostics
qqplot_path <- here::here("subproject2/output/model", "model_upsampled.png")
png(qqplot_path, width = 1600, height = 1200)
par(mfrow = c(2, 2))
plot(model_upsampled)
dev.off()

# Predicting probabilities
df_balanced$predicted_probabilities <- predict(model_upsampled, type = "response")

# Binarizing predictions based on a 0.5 threshold
df_balanced$predicted_ICU_class <- ifelse(df_balanced$predicted_probabilities > 0.5, 1, 0)

# Creating a confusion matrix
confusion_matrix <- table(Predicted = df_balanced$predicted_ICU_class, Actual = df_balanced$ICU)
confusion_matrix_upsampled<-kable(confusion_matrix, caption = "Confusion matrix_upsampled")

saveRDS(
  confusion_matrix_upsampled,
  file = here::here("subproject2/output/model/confusion_matrix_upsampled.rds")
)
# Varible selection

# Null model with no predictors
null_model <- glm(ICU ~ 1, 
                  data = df_balanced, 
                  family = binomial)

stepwise_model <- step(null_model,
                       scope = list(lower = null_model, upper = model_upsampled),
                       direction = "both",
                       trace = FALSE) # Set trace=TRUE to see step-by-step details


summary(stepwise_model)
tidy_model <- tidy(stepwise_model)
stepwise_model_table <- kable(tidy_model, caption = "Table.Stepwise_model Summary", digits= 4)

saveRDS(
  stepwise_model_table,
  file = here::here("subproject2/output/model/stepwise_model_table.rds")
)

# Model Diagnostics
qqplot_path <- here::here("subproject2/output/model", "stepwise_model.png")
png(qqplot_path, width = 1600, height = 1200)
par(mfrow = c(2, 2))
plot(stepwise_model)
dev.off()

# Predicting probabilities
df_balanced$predicted_probabilities_stepwise <- predict(stepwise_model, type = "response")

# Binarizing predictions based on a 0.5 threshold
df_balanced$predicted_ICU_class_stepwise <- ifelse(df_balanced$predicted_probabilities_stepwise > 0.5, 1, 0)

# Creating a confusion matrix
confusion_matrix <- table(Predicted = df_balanced$predicted_ICU_class_stepwise, Actual = df_balanced$ICU)
confusion_matrix_stepwise<-kable(confusion_matrix,caption = "Confusion matrix_stepwise")

# No Improvement
saveRDS(
  confusion_matrix_stepwise,
  file = here::here("subproject2/output/model/confusion_matrix_stepwise.rds")
)

print(confusion_matrix)

# Calculating precision and recall values

# Repeat for upsampled and stepwise models
confusion_matrix_upsampled <- table(Predicted = df_balanced$predicted_ICU_class, Actual = df_balanced$ICU)
TP_upsampled <- confusion_matrix_upsampled[2, 2]
FP_upsampled <- confusion_matrix_upsampled[1, 2]
FN_upsampled <- confusion_matrix_upsampled[2, 1]
TN_upsampled <- confusion_matrix_upsampled[1, 1]

confusion_matrix_stepwise <- table(Predicted = df_balanced$predicted_ICU_class_stepwise, Actual = df_balanced$ICU)
TP_stepwise <- confusion_matrix_stepwise[2, 2]
FP_stepwise <- confusion_matrix_stepwise[1, 2]
FN_stepwise <- confusion_matrix_stepwise[2, 1]
TN_stepwise <- confusion_matrix_stepwise[1, 1]

# Now calculate Precision, Recall, and AUC for each model as shown before


# Model 2 - Upsampled model
precision_upsampled <- TP_upsampled / (TP_upsampled + FP_upsampled)
recall_upsampled <- TP_upsampled / (TP_upsampled + FN_upsampled)
auc_upsampled <- auc(roc(df_balanced$ICU, df_balanced$predicted_probabilities))

# Model 3 - Stepwise model
precision_stepwise <- TP_stepwise / (TP_stepwise + FP_stepwise)
recall_stepwise <- TP_stepwise / (TP_stepwise + FN_stepwise)
auc_stepwise <- auc(roc(df_balanced$ICU, df_balanced$predicted_probabilities_stepwise))

# Combine the metrics into one dataframe
metrics_comparison <- data.frame(
  Model = c("Upsampled", "Stepwise"),
  Precision = c( precision_upsampled, precision_stepwise),
  Recall = c( recall_upsampled, recall_stepwise),
  AUC = c(auc_upsampled, auc_stepwise)
)

# Using kable to create a nice table
metrics_comparison_table <- kable(metrics_comparison, 
                                  caption = "Table. Comparison of Model Metrics", 
                                  digits = 4)

# Save the table as an RDS file
saveRDS(
  metrics_comparison_table,
  file = here::here("subproject2/output/model_evaluation/metrics_comparison_table.rds")
)

# Calculate ROC curves for each model
roc_curve_upsampled <- roc(df_balanced$ICU, df_balanced$predicted_probabilities)
roc_curve_stepwise <- roc(df_balanced$ICU, df_balanced$predicted_probabilities_stepwise)

# Plotting the ROC curves on the same plot
plot(roc_curve_upsampled, col = "red", main="ROC Curves Comparison", xlim = c(0, 1), ylim = c(0, 1))
lines(roc_curve_stepwise, col = "blue")
abline(a = 0, b = 1, lty = 2) # Adding a diagonal line for reference

# Adding a legend to distinguish the models
legend("bottomright", legend = c("Upsampled", "Stepwise"), col = c("red", "blue"), lwd = 2)

# Save the ROC plot to a file
roc_plot_path <- here::here("subproject2/output/model_evaluation", "ROC_Curve_Comparison.png")
png(roc_plot_path, width = 1600, height = 1200)
plot(roc_curve_upsampled, col = "red", main="ROC Curves Comparison", xlim = c(0, 1), ylim = c(0, 1))
lines(roc_curve_stepwise, col = "blue")
abline(a = 0, b = 1, lty = 2) # Adding a diagonal line for reference
legend("bottomright", legend = c("Upsampled", "Stepwise"), col = c("red", "blue"), lwd = 2)
dev.off()