# SOURCE: 
# https://codeclimate.com/blog/7-ways-to-decompose-fat-activerecord-models/

# NOTES:
# Decorator Objects
# 
# Decorators let you layer on functionality to existing operations, and therefore serve a similar 
# purpose to callbacks. For cases where callback logic only needs to run in some circumstances or 
# including it in the model would give the model too many responsibilities, a Decorator is useful.
#
# Posting a comment on a blog post might trigger a post to someone’s Facebook wall, 
# but that doesn’t mean the logic should be hard wired into the Comment class. 
# One sign you’ve added too many responsibilities in callbacks is slow and brittle tests 
# or an urge to stub out side effects in wholly unrelated test cases.
#
# Here’s how you might extract Facebook posting logic into a Decorator:

class FacebookCommentNotifier
  def initialize(comment)
    @comment = comment
  end

  def save
    @comment.save && post_to_wall
  end

private

  def post_to_wall
    Facebook.post(title: @comment.title, user: @comment.author)
  end
end

class CommentsController < ApplicationController
  def create
    @comment = FacebookCommentNotifier.new(Comment.new(params[:comment]))

    if @comment.save
      redirect_to blog_path, notice: "Your comment was posted."
    else
      render "new"
    end
  end
end
