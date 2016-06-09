# encoding: utf-8 

class WeeklyreportsController < ApplicationController
  unloadable

  #分页方法
  def paginate_collection(collection, options={})  
    default_options={:per_page => 5, :page => 1}  
    options=default_options.merge options  
    pages=Paginator.new self, collection.size, options[:per_page], options[:page]  
    first=pages.current.offset  
    last=[first + options[:per_page], collection.size].min  
    slice=collection[first...last]  
    return [pages, slice]  
  end  

  # GET /weeklyreports
  # GET /weeklyreports.json
  def index
  	@project = Project.find(params[:project_id])
		session[:project_id] = params[:project_id]
		session[:projectid] = @project.id
		
    #@local = 5
    #@count = Weeklyreport.count
    #@offset = 0
    #if params[:off]!=nil
     #  @offset=@local*params[:off].to_i
    #end
    #@weeklyreports = Weeklyreport.find(:all, :limit=>@local, :offset=>@offset).order("id desc")
    @weeklyreports = Weeklyreport.where("projectid = ?", @project.id).order("id desc")
    @pages, @weeklyreports = self.paginate_collection(@weeklyreports, :page => 1) 
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weeklyreports }
    end
  end

  # GET /weeklyreports/1
  # GET /weeklyreports/1.json
  def show
    @project = Project.find(session[:project_id])
    @weeklyreport = Weeklyreport.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @weeklyreport }
    end
  end

  # GET /weeklyreports/new
  # GET /weeklyreports/new.json
  def new
    @userid = User.current.id
    @project = Project.find(session[:project_id])
    @weeklyreport = Weeklyreport.new
    stime = Time.now        #获取当前日期
    d = stime.wday.to_i                          #获取星期几
    if d>=1 && d<=4
      temp = 7+d-1
    end
    if d==0
      temp = 6
    end
    if d>=5 && d<=6
      temp = d-1
    end
    @monday = stime-temp.day
    @sunday = @monday+6.day
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @weeklyreport }
    end
  end

  # GET /weeklyreports/1/edit
  def edit
    @project = Project.find(session[:project_id])
    @weeklyreport = Weeklyreport.find(params[:id])
  end

  # POST /weeklyreports
  # POST /weeklyreports.json
  def create
    @project = Project.find(session[:project_id])
    @weeklyreport = Weeklyreport.new(params[:weeklyreport])
    respond_to do |format|
      if @weeklyreport.save
        format.html { redirect_to @weeklyreport, notice: '创建成功' }
        format.json { render json: @weeklyreport, status: :created, location: @weeklyreport }
      else
        format.html { render action: "new" }
        format.json { render json: @weeklyreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /weeklyreports/1
  # PUT /weeklyreports/1.json
  def update
    @project = Project.find(session[:project_id])
    @weeklyreport = Weeklyreport.find(params[:id])
    respond_to do |format|
      if @weeklyreport.update_attributes(params[:weeklyreport])
        format.html { redirect_to @weeklyreport, notice: '更新成功' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @weeklyreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weeklyreports/1
  # DELETE /weeklyreports/1.json
  def destroy
    @project = Project.find(session[:project_id])
    @weeklyreport = Weeklyreport.find(params[:id])
    @weeklyreport.destroy
    respond_to do |format|
      format.html { redirect_to "/redmine/weeklyreports?project_id=#{session[:project_id]}" }
      format.json { head :no_content }
    end
  end
  
  def find_by_date
     @project = Project.find(session[:project_id])
    if params[:weeklyreport][:starttime].blank? && params[:weeklyreport][:endtime].blank?
      @weeklyreports = Weeklyreport.where("projectid = ?", session[:projectid]).order("id desc")
    end
    if params[:weeklyreport][:starttime].blank? && !params[:weeklyreport][:endtime].blank?
      @weeklyreports = Weeklyreport.where("projectid=? and starttime <= ?",session[:projectid], params[:weeklyreport][:endtime]).order("id desc")
    end    
    if !params[:weeklyreport][:starttime].blank? && params[:weeklyreport][:endtime].blank?
      @weeklyreports = Weeklyreport.where("projectid=? and starttime >= ?",session[:projectid],params[:weeklyreport][:starttime]).order("id desc")
    end
    if !params[:weeklyreport][:starttime].blank? && !params[:weeklyreport][:endtime].blank? 
      @weeklyreports = Weeklyreport.where("projectid=? and starttime between ? and ?",session[:projectid],params[:weeklyreport][:starttime], params[:weeklyreport][:endtime]).order("id desc")
    end
    @starttime = params[:weeklyreport][:starttime]
    @endtime = params[:weeklyreport][:endtime]
    respond_to do |format|
      format.html 
      format.json { render json: @weeklyreports }
    end
  end
  
end
