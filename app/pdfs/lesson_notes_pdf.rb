# coding: utf-8

class LessonNotesPdf < Prawn::Document

  def set_fallback_fonts
    chinese_path = "app/fonts/chinese.ttf"

    font_families.update("chinese" => {normal: chinese_path,
                                    bold: chinese_path,
                                    italic: chinese_path,
                                    bold_italic: chinese_path})
    arial_path = "app/fonts/arial.ttf"

    font_families.update("arial" => {normal: arial_path,
                                    bold: arial_path,
                                    italic: arial_path,
                                    bold_italic: arial_path})
    ipa_path = "app/fonts/ipa.ttf"

    font_families.update("ipa" => {normal: ipa_path,
                                    bold: ipa_path,
                                    italic: ipa_path,
                                    bold_italic: ipa_path})
  end


  
  def initialize(lesson, is_admin)
    @lesson = lesson
    @course = @lesson.course
    @is_admin = is_admin
    set_fallback_fonts
  fallback_fonts(["chinese", "ipa", "arial"])


    super()
    repeat :all do |d|
      draw_text "www.Yingwenxuexiao.com", at: [220, 0], color: "ababab"
    end
    show_header
    course_and_lesson
    vocabulary_table
  end

  def course_and_lesson
    text "#{@course.name}: #{@lesson.name}", size: 30, style: :bold, align: :center
  end

  def vocabulary_table
    move_down 20
    text "Vocabulary", size: 20, style: :bold, align: :center
    table vocabulary_words, position: :center do
      row(0).font_style = :bold
      row(0).style background_color: "00baf5"
      row(0).style text_color: "FFFFFF"
      row(0).column(1).style size: 10
      row(0).column(2).style size: 10
      row(0).column(3).style size: 8
      column(0).width = 100 
      column(1).width = 50
      column(2).width = 80
      column(4).width = 100
      column(5).width = 100
      self.row_colors = ["FFFFFF", "edf5fc"]
      self.header = true
    end
  end

  def vocabulary_words
    if @is_admin
      [["English", "IPA", "Part of Speech", "Definition", "Sentence"]] +
      @lesson.vocabulary_words.reverse.map do |vocablary_word|
        [vocablary_word.main, vocablary_word.ipa, vocablary_word.part_of_speech, vocablary_word.definition, vocablary_word.sentence]
      end
    else
      [["English", "Chinese", "IPA", "Part of Speech", "Definition", "Sentence"]] +
      @lesson.vocabulary_words.reverse.map do |vocablary_word|
        [vocablary_word.main, vocablary_word.chinese, vocablary_word.ipa, vocablary_word.part_of_speech, vocablary_word.definition, vocablary_word.sentence]
      end
    end
  end

  def show_header
    image "#{Rails.root}/app/assets/images/english_school_logo.jpg", width: 250, height: 100, at: [10, 740] unless @is_admin
    text @course.name, align: :right
    text @lesson.name, align: :right
    stroke_color "00baf5"
    line [0, 650], [540, 650]
    stroke
    move_down 50
  end

end