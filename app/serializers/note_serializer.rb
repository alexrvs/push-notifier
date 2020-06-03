class NoteSerializer < ActiveModel::Serializer
  attributes :id, :message, :received_at, :created_at
end