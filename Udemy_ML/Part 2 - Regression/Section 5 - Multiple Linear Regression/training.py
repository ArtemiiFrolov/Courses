import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
from sklearn.linear_model import LinearRegression
import statsmodels.formula.api as sm

dataset = pd.read_csv("50_Startups.csv")
X = dataset.iloc[:,:-1].values
y = dataset.iloc[:,-1].values




labelencoder_X = LabelEncoder ()
X[:,3] = labelencoder_X.fit_transform(X[:,3])

#one hot encoding
onehotencoder = OneHotEncoder(categorical_features=[3])
X = onehotencoder.fit_transform(X).toarray()

X = X[:, 1:]

labelencoder_Y = LabelEncoder ()
y = labelencoder_Y.fit_transform(y)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2,
                                                    random_state=0)
regressor = LinearRegression()
regressor.fit(X_train, y_train)

y_pred = regressor.predict(X_test)

X = np.append(np.ones((X.shape[0], 1)), X, 1)
X_opt = X[:, [0, 1, 2, 3, 4, 5]]
regressor_OLS = sm.OLS(endog=y, exog=X_opt).fit()

#print (X)
X_opt = X[:, [0, 1, 2, 3, 5]]
regressor_OLS = sm.OLS(endog=y, exog=X_opt).fit()

X_opt = X[:, [0, 2, 3, 5]]
regressor_OLS = sm.OLS(endog=y, exog=X_opt).fit()

X_opt = X[:, [0, 3, 5]]
regressor_OLS = sm.OLS(endog=y, exog=X_opt).fit()

X_opt = X[:, [0, 3]]
regressor_OLS = sm.OLS(endog=y, exog=X_opt).fit()
print(regressor_OLS.summary())