Pod::Spec.new do |s|
  s.name         = "NPReportView"
  s.version      = "1.0.0"
  s.summary      = "多功能报表控件"

  s.description  = <<-DESC
                    支持跨行跨列的复合表头。
                    支持自定义风格样式。
                    支持响应点击和长按事件。
                    支持行高自适应。
                    支持排序功能。
                   DESC

  s.homepage     = "https://github.com/NoResound/NPReportView"
  s.license      = "MIT"
  s.author       = { "NoResound" => "resounding@yeah.net" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/NoResound/NPReportView.git", :tag => "1.0.0" }
  s.source_files = "NPReportView/*.{h,m}"
  s.requires_arc = true
end
