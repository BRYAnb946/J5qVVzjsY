# 代码生成时间: 2025-08-03 19:58:05
# scheduler_service.rb
# This file implements a simple task scheduler using Ruby and CUbA framework.
# It demonstrates the creation of a scheduled task with error handling,
# documentation, and follows Ruby best practices for maintainability and scalability.

require 'rufus-scheduler'

class SchedulerService
  # Initializes a new instance of SchedulerService with a Rufus::Scheduler.
  def initialize
    @scheduler = Rufus::Scheduler.start_new
  end

  # Schedules a task to be run at a specified time or interval.
  #
  # @param task [Symbol] The name of the task to be scheduled.
  # @param time_or_interval [String] The time at which to run the task or the interval between runs.
  # @param job [Proc] The block of code to be executed when the task is triggered.
  def schedule_task(task, time_or_interval, job)
    begin
      # Schedule the task using the provided time or interval and job.
      @scheduler.every time_or_interval do
        job.call
      rescue => e
        # Handle any errors that occur during the execution of the task.
        puts "Error executing task #{task}: #{e.message}"
      end
    rescue Rufus::Scheduler::InvalidScheduleError => e
      # Handle invalid schedule errors.
      puts "Invalid schedule for task #{task}: #{e.message}"
    end
  end

  # Stops the scheduler and clears all tasks.
  def stop
    @scheduler.stop
  end
end

# Example usage:
#
# scheduler_service = SchedulerService.new
# scheduler_service.schedule_task(:backup_task, '0 0 * * *', lambda { puts 'Running backup...' })
# scheduler_service.schedule_task(:cleanup_task, '1h', lambda { puts 'Running cleanup...' })

# scheduler_service.stop # To stop the scheduler when needed.
