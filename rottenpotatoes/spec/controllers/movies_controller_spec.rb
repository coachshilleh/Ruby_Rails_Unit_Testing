require 'spec_helper'
require 'rails_helper'

describe MoviesController do
    describe 'create a movie' do
      it 'should create a new movie' do
      movie_ = Movie.new(:title => 'Aladdin', :rating => 'G', :description => 'Shilleh', :release_date => '25-Nov-1992', :director => 'Faris')
      Movie.should_receive(:create!).and_return(movie_)
      post :create, {movie: {title: 'Aladdin'}}
      response.should redirect_to(movies_path)
    end
  end
    
    describe 'delete a movie' do
      it 'should delete a new movie' do
      movie_ = Movie.new(:title => 'Aladdin', :rating => 'G', :description => 'Shilleh', :release_date => '25-Nov-1992', :director => 'Faris', :id => "1")
      Movie.should_receive(:find).with("1").and_return(movie_)
      delete :destroy, {id: "1"}
      response.should redirect_to(movies_path)
    end
  end
  
    describe 'finding movies with the same director' do
      it 'should show all movies with the same director' do
        movie_ = Movie.new(:title => 'Aladdin', :rating => 'G', :description => 'Shilleh', :release_date => '25-Nov-1992', :director => 'Faris', :id => "1")
        movie_2 = Movie.new(:title => 'Transformers', :rating => 'G', :description => 'Shilleh', :release_date => '25-Nov-1992', :director => 'Faris', :id => "2")
        Movie.should_receive(:find).with('1').and_return(movie_)
        Movie.should_receive(:same_dir).with('1').and_return([movie_, movie_2])
        get :same_director, {:id => "1"}
        response.should render_template(:same_director)
    end
  end
  
    describe 'finding movies with the same director that has no director' do
      it 'should show nothing' do
        movie_ = Movie.new(:title => 'Aladdin', :rating => 'G', :description => 'Shilleh', :release_date => '25-Nov-1992', :director => 'Faris', :id => "1")
        Movie.should_receive(:find).with('1').and_return(movie_)
        Movie.should_receive(:same_dir).with('1').and_return(movie_)
        get :same_director, {:id => "1"}
        response.should render_template(:same_director)
        
    end
  end
  
end
