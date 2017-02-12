import os
from peewee import *
from ss3000.connectdatabase import ConnectDatabase
from ss3000.models import Story
from flask import Flask, request, session, g, redirect, url_for, abort, \
    render_template, flash, current_app


app = Flask(__name__)
app.secret_key = 'super secret key'  # the app needs a secret key for POST functions as I discovered


def init_db():
    ConnectDatabase.db.connect()
    ConnectDatabase.db.create_tables([Story], safe=True)


@app.cli.command('initdb')
def initdb_command():
    """Initializes the database."""
    init_db()
    print('Initialized the database.')


@app.teardown_appcontext
def close_db(error):
    """Closes the database again at the end of the request."""
    if hasattr(g, 'postgre_db'):
        g.postgre_db.close()


@app.route('/list')
@app.route('/')
def display_list():
    stories = Story.select().order_by(Story.id.desc())
    return render_template("list.html", stories=stories)


@app.route('/story/')
def get_new_story():
    return render_template("form.html")


@app.route('/story/', methods=['POST'])
def add_story():
    new_story = Story.create(storytitle=request.form['storytitle'],
                             userstory=request.form['userstory'],
                             criteria=request.form['criteria'],
                             businessvalue=request.form['businessvalue'],
                             estimation=request.form['estimation'],
                             status=request.form['status'])
    new_story.save()
    flash('New user story was successfully added.')
    return redirect(url_for('display_list'))


@app.route('/story/<story_id>')
def get_story_to_edit(story_id):
    story = Story.select().where(Story.id == story_id).get()
    return render_template("form.html", story=story)


@app.route('/story/edit/<story_id>', methods=['POST'])
def edit_story(story_id):
    story = Story.select().where(Story.id == story_id).get()
    story.storytitle = request.form['storytitle']
    story.userstory = request.form['userstory']
    story.criteria = request.form['criteria']
    story.businessvalue = request.form['businessvalue']
    story.estimation = request.form['estimation']
    story.status = request.form['status']
    story.save()
    flash('The user story was successfully updated.')
    return redirect(url_for('display_list'))


@app.route('/story/<int:story_id>', methods=['POST'])
def delete_story(story_id):
    Story.delete().where(Story.id == story_id).execute()
    flash('The user story was successfully deleted.')
    return redirect(url_for('display_list'))
