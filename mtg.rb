require 'cicero'

TAGS = Cicero.words(50).split(' ').uniq.reject{|w| w.length < 3}

def gen_category
  "category_#{rand(15)}"
end

def gen_date
  r = rand(365)
  day = '%02d' % (r % 31)
  month = '%02d' % (r % 13)
  year = 2015 + r % 3
  "#{year}-#{month}-#{day} 10:23:42"
end

def gen_tags
  tags = TAGS.sample(1 + rand(5))
  "\n  - #{tags.join("\n  - ")}"
end

def gen_frontmatter(n, title)
  """---
id: #{n}
title: #{title}
category: #{gen_category}
date: #{gen_date}
tags: #{gen_tags}
---
"""
end

def gen_paragraph(n)
  "\nParagraph #{n}\n-----------\n\n" + Cicero.paragraph
end

def gen_content(n, title)
  gen_frontmatter(n, title) + "#{title}\n#{'=' * title.length}\n\n" + Cicero.sentence + "\n" + gen_paragraph(1) + gen_paragraph(2)
end


1000.times do |n|
  title = Cicero.words(3 + rand(4))
  slug = title.downcase.gsub(' ', '_')
  File.open("#{n}_#{slug}.md", 'w') { |f| f.write(gen_content(n, title)) }
end
