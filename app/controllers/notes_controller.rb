class NotesController < ApplicationController
  
  before_action :set_note, only: %i[ show edit update destroy ]
  
  def index
    @recent_notes = Note.order(last_viewed_at: :desc).limit(3)
  
    if params[:query].present?
      @notes = Note.left_joins(:rich_text_body)
                   .where("notes.title ILIKE ? OR action_text_rich_texts.body ILIKE ?", 
                          "%#{params[:query]}%", "%#{params[:query]}%")
                   .page(params[:page]).per(5) 
    else
      @notes = Note.page(params[:page]).per(5)
    end
  end
      
  
  
  def show
    @note.update(last_viewed_at: Time.current)
  end
  
  def new
    @note = Note.new
  end
  
  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to @note, notice: "Note was successfully created."
    else
      flash.now[:alert] = "The note could not be saved. Please fill in all fields."
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @note.update(note_params)
      redirect_to @note,  notice: "Note was successfully updated."
    else
      flash.now[:alert] = "The note could not be updated. Please fill in all fields."
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @note.destroy
    redirect_to notes_path, notice: 'Nota eliminada correctamente.'
  end
  
  private
    def set_note
      @note = Note.find(params[:id])
    end
  
    def note_params
      params.expect(note: [ :title, :body ])
    end
  
  
end
