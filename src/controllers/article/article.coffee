sanitizer = require 'sanitizer'
mongoose = require 'mongoose'
ArticleCategory = mongoose.model 'ArticleCategory'
Article = mongoose.model 'Article'
Tag = mongoose.model 'Tag'

# 插入標籤
appendTag = (tagName, article)->
  Tag.findOne
    name: tagName
  , (err, tag)->
    throw err if err

    if !tag?
      tag = new Tag
        name: sanitizer.sanitize tagName
    tag.count += 1
    tag.save()
    article.tag.push tag._id
    article.save()

exports.newsPage = (req, res)->
  res.json
    sanxia: [{
      articleId: 1
      title: '期待已久，隆重登場'
      subtitle: '三峽鳶山公共托育中心'
      summerize: '三峽鳶山公共托育中心，終於正式成立，雖然等到第二十五間才來到三峽，但是公共托育服務的進駐，對於三峽來說一定是地區社會福利的一大佳音'
    },{
      articleId: 2
      title: '馬偕的第十三個貢獻'
      subtitle: '三峽長老教會'
      summerize: '馬偕沿著淡水河經大漢溪，將第十三個教會據點設於此地傳教行醫，當時平地人與原住民還在溝通不良的階段，更因盛行的出草，多少漢人因好奇走進內山便再沒出來過'
    },{
      articleId: 3
      title: '北大特區聯外道路'
      subtitle: '犧牲了誰？'
      summerize: '「臺北大學特定區聯外道路」一案已經規劃確定。僅剩大學路位於路衝的六戶還守著舊宅，他們要的不是天文數字的賠償，只求合理、能夠生存的金額，還有還給他們清白'
    }]
    yingge: [{
      articleId: 4
      title: '鶯歌八十年老煙囪'
      subtitle: '恐將消逝'
      summerize: '早年窯場滿佈、煙囪林立，是老一輩鶯歌人的共同記憶。位於國慶街與光明街路口的包子窯煙囪，便是現今僅存的七支老煙囪之一'
    },{
      articleId: 5
      title: '陶博館前天橋即將啟用'
      summerize: '陶博館前景觀橋是以「盤旋飛龍」為造型，將成為鶯歌的「陶都」門戶意象，此橋啟用後將完整串聯大漢溪左岸自行車道，便利兩岸行人往來及休閒'
    },{
      articleId: 6
      title: '鶴鳴山下蓋淡坑'
      subtitle: '山仔腳小村風情'
      summerize: '位於樹林的山佳小鎮舊名山仔腳，背倚群山面朝溪流，對於時常搭乘火車或居住於樹林鶯歌一帶的人都不陌生，但卻鮮少人知道這涵洞後的小社區曾是過去輝煌的礦產小鎮'
    }]
    shulin: [{
      articleId: 7
      title: '「麥」擱來啊！'
      subtitle: '麥仔園都市計畫的癥結'
      summerize: '今年十月二十七日，新北市政府城鄉發展局召開「三峽麥仔園地區都市計畫」第一次說明會，龍埔里里民高舉「反對區段徵收」、「官商勾結」等標語'
    },{
      articleId: 8
      title: '大漢溪畔的休閒好去處'
      subtitle: '鹿角溪人工濕地'
      summerize: '昏沉的午後不想待在屋內，卻不曉得該往何處去嗎？三峽客踩著自行車來到了鹿角溪人工濕地，豐富的濕地生態結合完善的大漢溪自行車道，讓峽客遇見不少特地走訪此地的車友'
    },{
      articleId: 9
      title: '聯外公車整併'
      subtitle: '851、852直抵鶯歌樹林'
      summerize: '851、852、853與855等四線公車自去年十月通車以來，一直以搭乘率不高為人所詬病，而經民眾反應後，交通局終於同意整併此四線公車'
    }]
    tucheng: [{
      articleId: 10
      title: '談判破裂'
      subtitle: '普安堂將強制拆除'
      summerize: '原地方法院裁定9點30分拆除普安堂。但昨晚文化部緊急發函予新北地院，希望緩拆舊堂與山門，再次協調普安堂與慈祐宮'
    },{
      articleId: 11
      title: '彈藥庫裡的農夫夢──邱顯輝'
      summerize: '在新北市土城區有一塊土地，原本被政府徵收當作國防部彈藥庫，裡頭的居民過著進出都要被管制的生活，現在國防部人員撤走了'
    },{
      articleId: 12
      title: '火與土的結合之美──'
      subtitle: '陶藝大師伍坤山'
      summerize: '沿著土城永豐路往山上走，少了人間煙火，多了鳥囀蟲鳴。這次峽客遠離都市喧囂，來到陶藝大師──伍坤山的家'
    }]

exports.categories = (req, res)->
  ArticleCategory.find
    allowNew: true
  , '-allowNew -__v'
  , (err, categories)->
    throw err if err
    res.json categories

exports.newArticle = (req, res)->
  checklist = ['title', 'content', 'category_id', 'tags', 'authors']
  for checker in checklist
    if !req.body[checker]?
      return res.json
        status: false
        code: 1
        msg: "Invalid Parameter"

  # Sanitizer
  req.body.title = sanitizer.sanitize req.body.title
  req.body.content = sanitizer.sanitize req.body.content

  article = new Article
    title: req.body.title
    content: req.body.content
    category: req.body.category_id

  for author in req.body.authors
    if author.type is 'self'
      article.author.push req.user._id
    else if author.member_id?
      article.author.push author.member_id
    else
      article.author_external.push sanitizer.sanitize author.name

  article.photo = req.body.photos if req.body.photos

  article.save (err)->
    throw err if err

    res.json
      status: true

  # Append tags
  for tag in req.body.tags
    appendTag tag, article

exports.articleList = (req, res)->
  Article.find()
    .populate('author', 'name')
    .populate('category', 'name')
    .select('title author author_external region category create_date')
    .exec (err, articles)->
      throw err if err

      res.json
        status: true
        articles: articles
