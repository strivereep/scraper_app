require 'rufus-scheduler'

Rufus::Scheduler.singleton.cron('5 0 * * *') do
  # starts the cron job every day after midnight
  SchedulerScraperJob.perform_async
end
