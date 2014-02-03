class DashboardsController < ApplicationController

  def show
    if current_user.runs.empty?
      redirect_to no_runs_path
    else
      @my_runs = current_user.runs
      @stats = Stats.new(current_user.runs)
    end
  end

  def no_runs

  end

  def fetch_runs
    current_user.fetch_runs
    redirect_to dashboard_path
  end
end
