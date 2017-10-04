from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
import re

with open ("dataFile.txt", "r") as myfile:
    sentences = myfile.read()


sentences = sentences.split('$*$*$')

analyzer = SentimentIntensityAnalyzer()

total = best = worst = bestRT = worstRT = 0.0
worstSen = bestSen = worstRTSen = bestRTSen = "none"

regex = r'compound: ([0-1].[0-9]*)'
for sentence in sentences:
    vs = analyzer.polarity_scores(sentence)
    total += vs['compound']
    
    if "RT @" in sentence:
        if vs['compound'] > bestRT:
            bestRT = vs['compound']
            bestRTSen = sentence
        
        if vs['compound'] > bestRT:
            worstRT = vs['compound']
            worstRTSen = sentence
    else:
        if vs['compound'] > best: 
            best = vs['compound']
            bestSen = sentence
    
        if vs['compound'] < worst:
            worst = vs['compound']
            worstSen = sentence

print total
print total/len(sentences)
print "Happiest tweet, " + str(best) + " : " + bestSen
print "Saddest tweet, " + str(worst) + " : " + worstSen
print "Happiest retweet, " + str(bestRT) + " : " + bestRTSen
print "Saddest retweet, " + str(worstRT) + " : " + worstRTSen