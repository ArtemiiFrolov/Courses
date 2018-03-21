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


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2,
                                                    random_state=0)
regressor = LinearRegression()
regressor.fit(X_train, y_train)

y_pred = regressor.predict(X_test)

X = np.append(np.ones((X.shape[0], 1)).astype(int), values=X, axis=1)
columns = np.arange(X.shape[1])
X_opt = X[:, columns]
max_p = 1
while max_p>0.05:
    X_opt = X[:, columns]
    regressor_OLS = sm.OLS(endog=y, exog=X_opt).fit()
    print(regressor_OLS.summary())
    max_p = np.max(regressor_OLS.pvalues)
    if max_p>0.05:
        del_column = np.argmax(regressor_OLS.pvalues)
        columns = np.delete(columns, del_column)

print (columns)


