require 'sanitize'
class QuestionsController < ApplicationController



	def index

		@question = Question.new
		if params[:question] && !(params[:question][:qcat] == '1')
				# @questions = Question.search(params[:question][:qcat])				
				@questions = Question.where('qcat = ?', params[:question][:qcat])
				@question.qcat = params[:question][:qcat]
			else
				 @questions = Question.includes(:user).all
				 @question.qcat = "1"
			end

		respond_to do |format|
			format.html # index.html.haml
			format.json { render :json => @question }
	 
		end
	end

	def adminlist
		# @questions = Question.all
		@questions = Question.includes(:user).all
	end
	
	def upvote_question
		puts "got to upvote_question"
		quid = params[:id]
		@question = Question.find(quid)
		@uper = User.find(current_user.id)
		
		up = User.get_up(@question.qupvotesfrom,current_user.id)   				# string list of users that have previously voted for question plus the uper
		upper = User.get_up(@uper.qupvotesto,quid)								# string list of users that uper has previously voted for plus the upee

		if !@question.qupvotesfromcount.nil?
				@question.update_attribute(:qupvotesfromcount , @question.qupvotesfromcount + 1 )
			else
				@question.update_attribute(:qupvotesfromcount ,  1 )
			end
			
		if @question.update_attribute(:qupvotesfrom , up )
				puts 'success writing to db'	
			else
				puts 'failure writing to db'
			end
		if @uper.update_attribute(:qupvotesto , upper )
				puts 'success writing to db'
			else
				puts 'failure writing to db'
			end		
	
	end
	
	def downvote_question
		puts "got to downvote_question"
		quid = params[:id]   
		@question = Question.find(quid) 
		@uper = User.find(current_user.id)
		
		down = User.get_down(@question.qupvotesfrom,current_user.id)
		downer = User.get_down(@uper.qupvotesto,quid)
		
		if !@question.qupvotesfromcount.nil?
				@question.update_attribute(:qupvotesfromcount , @question.qupvotesfromcount - 1 )
			else
				@question.update_attribute(:qupvotesfromcount ,  0 )   # this should never happen
			end
		
		if @question.update_attribute(:qupvotesfrom , down )
				puts 'success writing to db'
			else
				puts 'failure writing to db'
			end
		if @uper.update_attribute(:qupvotesto , downer )
				puts 'success writing to db'
			else
				puts 'failure writing to db'
			end		
	
	end
	
	def upvote_answer
		puts "got to upvote_answer"
		aid = params[:id]
		@answer = Answer.find(aid)
		@uper = User.find(current_user.id)
		
		up = User.get_up(@answer.aupvotesfrom,current_user.id)   				# string list of users that have previously voted for question plus the uper
		upper = User.get_up(@uper.aupvotesto,aid)								# string list of users that uper has previously voted for plus the upee

		if !@answer.aupvotesfromcount.nil?
				@answer.update_attribute(:aupvotesfromcount , @answer.aupvotesfromcount + 1 )
			else
				@answer.update_attribute(:aupvotesfromcount ,  1 )
			end
			
		if @answer.update_attribute(:aupvotesfrom , up )
				puts 'success writing to db'	
			else
				puts 'failure writing to db'
			end
		if @uper.update_attribute(:aupvotesto , upper )
				puts 'success writing to db'
			else
				puts 'failure writing to db'
			end	
		
		end
	
	def downvote_answer
		puts "got to downvote_answer"
		aid = params[:id]   
		@answer = Answer.find(aid) 
		@uper = User.find(current_user.id)
		
		down = User.get_down(@answer.aupvotesfrom,current_user.id)
		downer = User.get_down(@uper.aupvotesto,aid)
		
		if !@answer.aupvotesfromcount.nil?
				@answer.update_attribute(:aupvotesfromcount , @answer.aupvotesfromcount - 1 )
			else
				@answer.update_attribute(:aupvotesfromcount ,  0 )   # this should never happen
			end
		
		if @answer.update_attribute(:aupvotesfrom , down )
				puts 'success writing to db'
			else
				puts 'failure writing to db'
			end
		if @uper.update_attribute(:aupvotesto , downer )
				puts 'success writing to db'
			else
				puts 'failure writing to db'
			end		
	
	end	
		

  # GET /questions/list
  # GET /questions/list.json
  def list
    # @questions = Question.all
	@questions = Question.includes(:user).all
    respond_to do |format|
      format.html # list.html.haml
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
	@question = Question.find(params[:id])
	@answer = Answer.new
	@answers = Answer.includes(:comments).where("question_id = ?",@question.id).all
	@users = User.select("id,name")
    respond_to do |format|
      format.html # Answer.show.html.haml
      format.json { render json: @answer }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new
	
    respond_to do |format|
		
      format.html # new.html.haml
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(params[:question])
	@question.user_id = current_user.id 
	@question.deleted = false
    respond_to do |format|
      if @question.save
			dirty = @question.text
			clean = Sanitize.clean(dirty, Sanitize::Config::RELAXED)
			@question.update_attribute(:text ,  clean )
     #   format.html { redirect_to @question, notice: 'Question was successfully created.' }
		format.html { redirect_to questions_url }
        
		format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
			dirty = @question.text
			clean = Sanitize.clean(dirty, Sanitize::Config::RELAXED)
			@question.update_attribute(:text ,  clean )
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :ok }
    end
  end
end
