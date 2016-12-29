require "spec_helper"

describe Article do
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:body)}
  # it { should validate_presence_of(:main_image_url)}
  it { should belong_to(:author) }
  it { should have_many(:article_topics) }
  it { should have_many(:comments) }

  describe ".randomArticle([ids to exclude])" do

    it "returns a random article with one published article in the database" do
      article_1 = Fabricate(:article, published: true)
      expect(Article.randomArticle).to eq(article_1)
    end

    it "returns false if there are no articles" do
      expect(Article.randomArticle).to be_falsey
    end

    it "returns false if there is one unpublished article" do
      article_1 = Fabricate(:article)
      expect(Article.randomArticle).to be_falsey
    end

    it "returns false is all articles are unpublished" do
      article_1 = Fabricate(:article)
      article_2 = Fabricate(:article)
      article_3 = Fabricate(:article)
      article_4 = Fabricate(:article)
      article_5 = Fabricate(:article)
      expect(Article.randomArticle).to be_falsey
    end

    it "returns an article not included in the passed in range" do
      article_1 = Fabricate(:article, id: 1, published: true)
      article_2 = Fabricate(:article, id: 2, published: true)
      article_3 = Fabricate(:article, id: 3, published: true)
      article_4 = Fabricate(:article, id: 4, published: true)
      article_5 = Fabricate(:article, id: 5, published: true)

      expect(Article.randomArticle([2,3,4,5])).to eq(article_1)
    end

    it "returns an article not included in the passed in range 2" do
      article_1 = Fabricate(:article, id: 1, published: false)
      article_2 = Fabricate(:article, id: 2, published: true)
      article_3 = Fabricate(:article, id: 3, published: true)
      article_4 = Fabricate(:article, id: 4, published: true)
      article_5 = Fabricate(:article, id: 5, published: true)

      expect(Article.randomArticle([2,3,4])).to eq(article_5)

    end

    it "returns an article not included in the passed in range 2" do
      article_1 = Fabricate(:article, id: 1, published: false)
      article_2 = Fabricate(:article, id: 2, published: true)
      article_3 = Fabricate(:article, id: 3, published: true)
      article_4 = Fabricate(:article, id: 4, published: true)
      article_5 = Fabricate(:article, id: 5, published: true)

      expect(Article.randomArticle([article_2.id, article_3.id, article_4.id])).to eq(article_5)

    end
  end

  describe "#preiview_text" do
    let(:article)  { Fabricate(:article, body: "Lorem </h1>Title</h1> <img src='neat_pic.png' /> ipsum dolor sit amet, consectetur adipisicing elit. Inventore accusantium, delectus! Autem molestias ullam consequuntur expedita unde? Odio, quaerat? Quibusdam, reiciendis, recusandae! Inventore, officia. Repellendus eius ipsam cupiditate quo natus?") }

    it "only returns the first 200 characters plus ' ...' if the body length is long" do
      expect(article.preview_text.length).to eq(204) 
    end

    it "returns the whole body if the body is shorter than 200 characters" do
      short_body = Fabricate(:article, body: "this is the body")
      expect(short_body.preview_text).to eq(short_body.body)
    end
  end

end