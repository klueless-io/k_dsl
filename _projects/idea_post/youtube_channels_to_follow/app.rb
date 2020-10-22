# ------------------------------------------------------------
# Idea for a Blog Post
# ------------------------------------------------------------

KDsl.microapp :youtube_channels_to_follow do
  s = settings do
    name                          parent.key
    app_type                      'idea-blog-post'
    post_type                     'listicle'
    description                   '[Youtube Channels To Follow] is a Listicle article that will be written for the David Cruwys website'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'youtube_channels_to_follow'
    website                       'http://appydave.com/idea_post/youtube_channels_to_follow'
    source                        ['https://dev.to/adriantwarog/40-amazing-developers-you-should-follow-on-youtube-5bhh',
                                   'https://careerkarma.com/blog/top-coding-youtube-channels-2020/']
    publish_on                    ['dev.to', 'quora', 'reddit']
    title                         '80 Awesome Youtube Channels To Follow in 2021'
    app_path                      '~/dev/idea_post/youtube_channels_to_follow'
    data_path                     '_/.data'
  end

  # Screenshots

  table 'someimage.png' do
    fields %i[bullet_point section description]

    # row 1, 'text'                   , 'input area that will take text that needs to be written' 
    # row 2, 'generate_voiceover'     , 'Click this button to generate a voice over' 
    # row 3, 'id'                     , 'Voice over ID can be used for selection purposes for (delete or download)' 
    # row 4, 'delete'                 , 'Click this button to delete the selected voice over' 
    # row 5, 'download'               , 'Click this button to download the voiceover' 
  end

  # Commands

  table :listicle do
    fields %i[name url description]

    # Write a script that can (for each of these channels) 
    # - get the subscriber count
    # - get the description
    # - take a screen shot and make it pretty

    # Strategy: 10 Listicles are best so, it might be good to come up with groupings and do multiple 10x articles

    # 'https://careerkarma.com/blog/top-coding-youtube-channels-2020/'

    # 'https://dev.to/adriantwarog/40-amazing-developers-you-should-follow-on-youtube-5bhh'

    row 'Ben Awad'               , url: 'https://www.youtube.com/channel/UC-8QAzbLcRglXeN_MY9blyw'
    row 'The Coder Coder'        , url: 'https://www.youtube.com/thecodercoder'
    row 'Brad Traversy'          , url: 'https://www.youtube.com/user/TechGuyWeb'
    row 'Dev Ed'                 , url: 'https://www.youtube.com/channel/UClb90NQQcskPUGDIXsQEz5Q'
    row 'Florin Pop'             , url: 'https://www.youtube.com/c/florinpop'
    row 'Fireship IO'            , url: 'https://www.youtube.com/channel/UCsBjURrPoezykLs9EqgamOA'
    row 'Danny Thompson'         , url: 'https://www.youtube.com/DThompsonDev'
    row 'The Net Ninja'          , url: 'https://www.youtube.com/c/thenetninja'
    row 'Niall Maher'            , url: 'https://www.youtube.com/channel/UCvI5azOD4eDumpshr00EfIw/'
    row 'William Candillon'      , url: 'https://www.youtube.com/channel/UC806fwFWpiLQV5y-qifzHnA'
    row 'developerHabits'        , url: 'https://www.youtube.com/channel/UCJLZwePkNHps5Bv7VwISyTA'
    row 'Tim'                    , url: 'https://youtube.com/techwithtim'
    row 'Gary Simon'             , url: 'https://www.youtube.com/user/DesignCourse'
    row 'James Q Quick'          , url: 'https://www.youtube.com/channel/UC-T8W79DN6PBnzomelvqJYw'
    row 'Weibenfalk'             , url: 'https://www.youtube.com/user/Weibenfalk'
    row 'Kevin Powell'           , url: 'https://www.youtube.com/user/KepowOb'
    row 'Dennis Ivy'             , url: 'https://www.youtube.com/c/DennisIvy'
    row 'codeSTACKr'             , url: 'https://www.youtube.com/codeSTACKr'
    row 'Chris Sean'             , url: 'https://www.youtube.com/c/ChrisSean'
    row 'Program With Erik'      , url: 'https://www.youtube.com/c/programwitherik'
    row 'Swizec Teller'          , url: 'https://www.youtube.com/channel/UCoyHgaeLLI7Knp7LDHOwZMw'
    row 'Faraday Academy'        , url: 'https://youtube.com/c/FaradayAcademy'
    row 'Web Dev Simplified'     , url: 'https://www.youtube.com/channel/UCFbNIlppjAuEX4znoulh0Cw'
    row 'Coding Garden'          , url: 'https://www.youtube.com/channel/UCLNgu_OupwoeESgtab33CCw'
    row 'JavaScript Mastery'     , url: 'https://www.youtube.com/JavaScriptMastery/'
    row 'Code with Ania Kubów'   , url: 'https://www.youtube.com/aniakubow'
    row 'CodingTutorials360'     , url: 'https://www.youtube.com/codingtutorials360'
    row 'Caleb Curry'            , url: 'https://www.youtube.com/calebthevideomaker2'
    row 'RealToughCandy'         , url: 'https://www.youtube.com/realtoughcandy'
    row 'Eddie Jaoude'           , url: 'https://youtube.com/eddiejaoude'
    row 'Eleftheria Batsou'      , url: 'https://www.youtube.com/c/eleftheriabatsou'
    row 'Jesse Showalter'        , url: 'https://www.youtube.com/JesseShowalter'
    row 'Catalin Pit'            , url: 'https://www.youtube.com/CatalinPit'
    row 'CodingEntrepreneurs'    , url: 'https://www.youtube.com/CodingEntrepreneurs/'
    row 'CoderOne'               , url: 'https://www.youtube.com/coderone'
    row 'Classsed'               , url: 'https://www.youtube.com/classsed'
    row 'Chau Codes'             , url: 'https://youtube.com/chaucodes'
    row 'Dev Mentor Live'        , url: 'https://youtube.com/dementorlive'
    row 'Claudio Bernasconi'     , url: 'https://www.youtube.com/channel/UCTbHPk0bIOQwTXuGgD195bw'
    row 'Free Code Camp'         , url: 'https://www.youtube.com/channel/UC8butISFwT-Wl7EV0hUK0BQ'    

    # 'https://dev.to/adriantwarog/40-amazing-developers-you-should-follow-on-youtube-5bhh'

    row 'Hussein Nasser'         , url: 'https://www.youtube.com/user/GISIGeometry'
    row 'Programming with Mosh'  , url: 'https://www.youtube.com/c/programmingwithmosh'
    row 'NeuralNine'             , url: 'https://www.youtube.com/c/NeuralNine'
    row ''                       , url: ''
  end

  actions do
    # write_html using: :listicle

  end

end
