drop table if exists story;
create table story (
  id integer primary key autoincrement,
  storytitle text not null,
  usersstory text not null,
  criteria text not null,
  businessvalue integer not null,
  estimation float not null,
  status text,
);
BEGIN;
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('System / Handle new application', 'As an Administrator,
I want to automate the process of incoming applications
So that I can save some time (of manual work).', 'Given that there is a new applicant in the ""applicants"" db table
And it has no application code and school yet
When the system detects this new entry
Then ensure the program assigns a generated application code for the applicant
  And ensure the program finds the closest school based on the city (using the City model)
  And ensure these new VALUES are saved to the Applicant.', '1000', '12.5', 'done');
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('System / Find possible interview date', 'As an Administrator,
I want to automate the process of scheduling interviews
So that I can save some time (of manual work).', 'Given that there is a new applicant in the ""applicants"" db table
  And it has no scheduled interview yet
When the system detects this entry
Then ensure the program finds a possible interview date based on the availability of mentors (using the InterviewSlot model)
  And ensure the program saves a new Interview with all necessary data
  And reserves the selected interview slot of the mentor, so others cannot re-reserve it (and cause conflict).',	'1000', '12.5', 'done');
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('Applicant view / Application', 'As an Applicant,
I want to see the details of my application
So that I can be informed about my evaluation.', 'Given that there is an application code
  And it exists in the database
When the user chooses the ""Application Details"" menu
Then ensure the program displays the status of the application (new/in progress/accepted/rejected)
  And ensure the program displays the name of the school.', '1000', '12.5', 'done');
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('Applicant view / Interview', 'As an Applicant,
I want to see the details of my possible interview
So that I can prepare for the date/time.', 'Given that there is an application code
  And it exists in the database
  And it has a scheduled interview
When the user chooses the ""Interview Details"" menu
Then ensure the program displays the date/time of the interview
  And ensure the program displays the name of the school
  And ensure the program displays the name of the mentor.', '700', '12.5', 'done');
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('Applicant view / Questions', 'As an Applicant,
I want to see the answers to my questions
So that I can read them as soon as they answered.', 'Given that there is an application code
  And it exists in the database
  And it has connected questions/and answers
When the user chooses the ""Questions"" menu
Then ensure the program displays the questions of the user
  And ensure the program displays the status of the questions (new/waiting for answer/answered)
  And ensure the program displays the answers by questions if there is any.', '600', '12.5', 'done');
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('Administrator view / Applicants', 'As an Administrator,
I want to see the list of all applicants
So that I can check the data and detect problems.', 'Given that there is an admin interface with filterable lists
When the user chooses the ""Applicants"" menu
Then ensure the program displays the applicants (with all the data from the filters)
  And ensure the list is filterable 
  - by status
  - by time
  - by location
  - by personal data (name, email)
  - by school
  - by mentor name (through interview).', '800', '12.5', 'done');
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('Administrator view / Interviews', 'As an Administrator,
I want to see the list of all scheduled interviews
So that I can check the data and detect problems.', 'Given that there is an admin interface with filterable lists
When the user chooses the ""Interviews"" menu
Then ensure the program displays the scheduled interviews (with all the data from the filters)
  And ensure the list is filterable 
  - by school
  - by applicant (application code)
  - by mentor
  - by date.', '300', '12.5', 'done');
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('Administrator view / Questions', 'As an Administrator,
I want to see the list of all questions from applicants
So that I can assign questions to mentors.', 'Given that there is an admin interface with filterable lists
When the user chooses the ""Questions"" menu
Then ensure the program displays the questions (with all the data from the filters)
  And ensure the list is filterable 
  - by status
  - by time
  - by applicant (application code)
  - by school
  - by mentor name,
When the user chooses one question from the list
Then ensure the user can assign a mentor who will be responsible to answer that question
  And ensure it changes the status of the question (from ""new"" to ""waiting for answer"")', '600', '12.5', 'done');
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('Mentor view / Interviews', 'As a Mentor,
I want to see the list of all scheduled interviews for me
So that I can check the dates when i have to do interviews.', 'Given that there is a mentor interface and a selected mentor (as current user)
When the user chooses the ""Interviews"" menu
Then ensure the program displays the scheduled interviews with all the following data:
  - date/time
  - application code
  - applicant name.', '400', '12.5', 'done');
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('Mentor view / Questions', 'As a Mentor,
I want to see the list of all incoming (assigned) questions to me
So that I can answer them (one by one).', 'Given that there is a mentor interface and a selected mentor (as current user)
When the user chooses the ""Questions"" menu
Then ensure the program displays questions 
  (which has ""waiting for answer"" status and assigned to the user) with all the following data:
  - date/time
  - application code (of applicant who asked the question),
  - question,
When the user chooses one question from the list
Then ensure the user can answer the question with some text
  And ensure it changes the status of the question (from ""waiting for answer"" to ""answered"")', '600', '12.5', 'done');
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('System / Email applicants about their city assignment', 'As an Applicant,
I want to get an email when my application has been handled
So that I can be informed about the my application code and the city I have been assigned to', 'Given that the handle new application script is running
When the script handles a new application
Then the script sends an email to the applicant:
- with an appropiate invocation with the applicants name
- containing her/his application code, and the city she/he has been assigned to
- using the developers Gmail accounts for the SMTP configuration', '1000', '12.5', 'done');
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('System / Email applicants about their interview slot', 'As an Applicant,
I want to get an email when I have been assigned to an interview slot
So that I can be informed about the appropriate time I have to attend', 'Given that the find possible interview slot script is running
When the script assigns an applicant to a slot
Then the script sends an email to the applicant:
- with an appropiate invocation with the applicants name
- containing the information about the assigned mentors name and the selected time-slot
- using the developers Gmail accounts for the SMTP configuration', '500', '12.5', 'done');
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('System / Email mentors about their interview slot', 'As a Mentor,
I want to get an email when I have been assigned to an interview slot
So that I can be informed about the appropriate time I have to attend', 'Given that the find possible interview slot script is running
When the script assigns a mentor to a slot
Then the script sends an email to the mentor
- with an appropiate invocation with the mentors name
- containing the information about the assigned applicants name and the selected time-slot
- using the developers Gmail accounts for the SMTP configuration', '500', '12.5', 'done');
INSERT INTO story(storytitle, userstory, criteria, businessvalue, estimation, status) VALUES('System / Find possible interview date for 2 mentors',	'As an Administrator,
I want to modify the automated interview selection process
So that it reserves 2 mentors for an interview', 'Given that the find possible interview slot script is running
When the script processes an application with no selected interview slot
Then ensure the program finds a possible interview date based on the availability of mentors (using the InterviewSlot model)
- with saving 2 mentors / applicant for an interview
- with modifying all the related UI to display all the mentors interviewing', '800', '12.5', 'done');
COMMIT;
