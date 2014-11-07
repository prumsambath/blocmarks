class IncomingMailsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]

  def initialize(email)
    @email = email
  end

  def create
    bookmark = BookmarkMailer.receive @email
    # TODO how to respond after receiving an incoming email
    if !bookmark.new_record?
      render text: 'Success', status: 201
    else
      render text: bookmark.errors.full_messages.join(', '), status: 422
    end

  end
end
