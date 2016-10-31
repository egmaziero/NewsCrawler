from sys import argv
from guess_language import guess_language

script, file = argv
f = open(file,'r')

text = ""
for i in range(0,3):
	text = text+f.readline()

language = guess_language.guessLanguage(text)
print language