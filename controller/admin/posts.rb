module Admin
  class Posts < Controller
    map 'posts'

    def index
      @posts = current_user.posts
    end

    def edit(id)
      @post = find_post(id)
    end

    def save
      redirect Posts.r('') unless request.post? || request.put?
      data = request.subset(*%i(title body published))
      post = find_post(request.subset(:id)['id'])
      post.set(data)
      post.save
    end

    def destroy
    end

    private
    def find_post(id)
      Post.where(id: id, user_id: current_user.id).first || Post.new(user_id: current_user.id)
    end
  end
end
