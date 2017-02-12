from ss3000.connectdatabase import ConnectDatabase
from peewee import *


class Story(Model):
    storytitle = CharField()
    userstory = TextField()
    criteria = TextField()
    businessvalue = IntegerField()
    estimation = FloatField()
    status = CharField()

    class Meta:
        database = ConnectDatabase.db
