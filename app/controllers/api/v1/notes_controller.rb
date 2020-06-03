module Api
  module V1
    class NotesController < Api::BaseController

      def create
        @note = current_user.notes.create!(note_params)
        NotifierService.new(@note, current_user).process!
        render_this(obj: @note)
      end

      private

      def note_params
        params.require(:note).permit(:message, :received_at)
      end
    end
  end
end