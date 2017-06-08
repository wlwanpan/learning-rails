
class StatsController < ApplicationController

  def index
    redirect_to "main#index"
  end

#   def new
#     @stat = subber.stats.new permitted_param
#     @stat.save
#   end
#
#   def create
#     unless User.exists?(data_title: params[:data_title])
#       @subber = subber
#       @stat = @subber.stats.build(params[:subber])
#       @stat.save
#     end
#   end
#
#   def update
#     @stat = stat
#     @stat.assign_attributes permitted_param
#     @stat.save
#   end
#
#   def destroy
#     @stat = stat
#     @stat.each do |book|
#       book.destroy
#     end
#   end
#
# private
#   def subber
#     Subber.find(params[:subber_id])
#   end
#
#   def stat
#     subber.stats.find(params[:id])
#   end
#
#   def permitted_param
#     parms.require(:stat).permit(:a,:b)
#   end

end
