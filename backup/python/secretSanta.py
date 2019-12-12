import csv
import random
import yagmail
yag = yagmail.SMTP('sdsantasecret', 'la ya le mot de passe normalement')

class Santa:
    def __init__(self, fullName, firstName, email):
        self.fullName = fullName
        self.firstName = firstName
        self.email = email

def sendmail(santa, santy):
    content = [
        'MAIL TOP SECRET !!!',
        '\n',
        'Salut ' + santa.firstName + ',',
        '\n'
        'Tu as été choisi pour offrir un cadeau à ' + santy.fullName,
        'Attention cette information doit rester secrète jusqu\'à la remise des cadeaux',
        'Rappel : Distribution des cadeaux : lundi 6 janvier, Budget : 20€ max',
        '\n',
        'Bonne fêtes à toutes et à tous'
    ]
    yag.send(santa.email, 'Secret Santa 2019', content)

def getListing():
    listing = []
    fname = "table.csv"
    file = open(fname, "r")
    try:
            reader = csv.reader(file)
            for row in reader:
                listing.append(Santa(row[0], row[1], row[2]))
    finally:
            file.close()
    return listing

santasList = getListing()

random.shuffle(santasList)

sendmail(santasList[-1], santasList[0])

for i in range(len(santasList)-1) :
    sendmail(santasList[i], santasList[i+1])
