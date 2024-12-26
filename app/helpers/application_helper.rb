module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'DayOutLog'
    
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def default_meta_tags
    {
      site: 'DayOutLog',
      title: '1日のお出かけ記録を共有するサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'DayOutLogでは散歩から旅行まで様々なお出かけ記録を時系列で投稿し、ユーザー同士で共有することができます。',
      keywords: '旅行,散歩,アウトドア,共有',
      canonical: 'https://www.dayoutlog.com/',
      separator: '|',
      og:{
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: 'https://www.dayoutlog.com/',
        image: image_url('DayOutLog_OGP.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@obvyamdrss',
        image: image_url('DayOutLog_OGP.png')
      }
    }
  end
end