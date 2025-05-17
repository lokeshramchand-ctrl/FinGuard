import pickle
import json

model = pickle.load(open('model.pkl', 'rb'))
vectorizer = pickle.load(open('vectorizer.pkl', 'rb'))

# Read from standard input
input_data = json.loads(input())
description = input_data.get("description", "").lower()

text_vec = vectorizer.transform([description])
prediction = model.predict(text_vec)[0]

print(prediction)
