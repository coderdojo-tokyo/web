Parse.Cloud.job 'syncMeetups', require 'cloud/job/syncMeetups'
Parse.Cloud.beforeSave 'Meetup', require 'cloud/hook/Meetup_beforeSave'
Parse.Cloud.beforeSave 'Mentor', require 'cloud/hook/Mentor_beforeSave'
