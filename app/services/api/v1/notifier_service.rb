module Api
  module V1
    class NotifierService
      attr_reader :note, :user

      def initialize(note, user)
        @note = note
        @user = user
      end

      def process!
        @user.devices.each do |device|
          IosNotifierWorker.perform_at(1.minute.from_now, @note.message) if device.ios?
          AndroidNotifierWorker.perform_at(1.minute.from_now, @note.message) if device.android?
        end
      end

    end
  end
end