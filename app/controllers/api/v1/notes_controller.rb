module Api
  module V1
    class NotesController < Api::BaseController

      param :user, Hash, :desc => "User info" do
        param :message, String, :desc => "Message of note", :required => true
        param :received_at, DateTime, :desc => "Date of note", :required => true
      end

      api :POST, "/v1/notes", "Create Note"
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