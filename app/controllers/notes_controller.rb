class NotesController < ApplicationController
  before_action :set_note, only: %i[show edit update destroy]

  def index
    @recent_notes = Current.user.notes.order(last_viewed_at: :desc).limit(3)


    if params[:query].present?
      @notes = Current.user.notes.left_joins(:rich_text_body)
                  .where("notes.title ILIKE ? OR action_text_rich_texts.body ILIKE ?",
                         "%#{params[:query]}%", "%#{params[:query]}%")
                  .page(params[:page]).per(5)
    else
      @notes = Current.user.notes.page(params[:page]).per(5)
    end
  end

  def show
    @note.update(last_viewed_at: Time.current)
  end

  def new
    @note = Note.new
  end

  def create
    @note = Current.user.notes.new(note_params)

    if @note.save
      redirect_to @note, notice: "Nota creada con éxito."
    else
      flash.now[:alert] = "La nota no pudo ser guardada. Por favor, complete todos los campos."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @note = Current.user.notes.find(params[:id])
  end

  def update
    @note = Current.user.notes.find(params[:id])

    if @note.update(note_params)
      redirect_to @note, notice: "Nota actualizada correctamente."
    else
      flash.now[:alert] = "La nota no pudo ser actualizada. Por favor, complete todos los campos."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note = Current.user.notes.find(params[:id])
    @note.destroy
    redirect_to notes_path, notice: "Nota eliminada correctamente."
  end

  private

  def set_note
    @note = Current.user.notes.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :body)
  end
end
