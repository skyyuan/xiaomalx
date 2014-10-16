# encoding: utf-8

#-*- encoding: utf-8 -*-
desc "Add tag init"
task :add_tag => :environment  do
  tag_arr = ['level','country','profe','other']
  level_tag = ['高中','本科','研究生']
  country_tag = ['美国','英国','欧洲','澳洲','加拿大','香港','新加坡','亚洲']
  profe_tag = ['商科','工科','理科','文科','艺术']
  other_tag = ['推荐信撰写','简历撰写','签证办理','移民','转学','退学']
  profe_children_tag = ['会计','经济','管理','市场营销','物流管理','酒店管理','人力资源管理','金融']
  gk_tag = ['计算机工程','电子电器工程','机械工程','土木工程','化学工程','生物工程','材料工程','环境工程']
  lk_tag = ['数学']
  wk_tag = ['语文','地理','英语']
  ys_tag = ['舞蹈','美术','影视']

  tag_arr.each do |tag|
    cat = Category.create(name: tag)
    if tag == 'level'
      level_tag.each do |l|
        Category.create(name: l, parent_id: cat.id)
      end
    end
    if tag == 'country'
      country_tag.each do |l|
        Category.create(name: l, parent_id: cat.id)
      end
    end
    if tag == 'profe'
      profe_tag.each do |l|
        cat_p = Category.create(name: l, parent_id: cat.id)
        if l == '商科'
          profe_children_tag.each do |pc|
            Category.create(name: pc, parent_id: cat_p.id)
          end
        end
        if l == '工科'
          gk_tag.each do |gk|
            Category.create(name: gk, parent_id: cat_p.id)
          end
        end
        if l == '理科'
          lk_tag.each do |lk|
            Category.create(name: lk, parent_id: cat_p.id)
          end
        end
        if l == '文科'
          wk_tag.each do |wk|
            Category.create(name: wk, parent_id: cat_p.id)
          end
        end
        if l == '艺术'
          ys_tag.each do |ys|
            Category.create(name: ys, parent_id: cat_p.id)
          end
        end
      end
    end
    if tag == 'other'
      other_tag.each do |l|
        Category.create(name: l, parent_id: cat.id)
      end
    end
  end


end