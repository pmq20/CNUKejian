# -*- encoding : utf-8 -*-
module ApplicationHelper

  def gap(time)
    secs = Time.now - time

    if secs<=60
      return "#{secs.to_i}秒"
    elsif secs<=60*60
      return "#{(secs/60).to_i}分钟"
    elsif secs<=60*60*24
      return "#{(secs/3600).to_i}小时"
    elsif secs<=60*60*24*30
      return "#{(secs/(3600*24)).to_i}天"
    elsif secs<=60*60*24*30*12
      return "#{(secs/(3600*24*30)).to_i}个月"
    else
      return "#{(secs/(3600*24*30*12)).to_i}年"
    end
  end

	def give_alert(msg)
		ret = <<MSG
	<table width="100%" cellspacing="0" cellpadding="0" border="0" style="">
		            <tbody><tr> 
		              <td valign="top"> 
				
	<table width="100%" cellspacing="0" cellpadding="0" border="0" class="error">
					   <tbody><tr> 
					     <td valign="top">
					<table width="100%" cellspacing="0" cellpadding="0" border="0" class="errorLine">
		                  <tbody><tr> 
		                    <td height="5" colspan="4"></td>
		                  </tr>
		                  <tr>
		                    <td width="5">&nbsp;</td> 
		                    <td width="32" valign="top"><img width="32" height="32" src="/images/icon/alert.gif"></td>
		                    <td width="5">&nbsp;</td>
		                    <td valign="top">
		                    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="error">             
							<tbody><tr><td class="errorSpot"></td>
							<td class="errorTop">
							<strong><font color="#990000">
MSG
			ret += msg
			ret += <<MSG				
							</font></strong><br>
							</td>
							</tr>   					
							</tbody></table>
		                    </td>
		                  </tr>
		                  <tr> 
		                    <td height="5" colspan="4"></td>
		                  </tr>
		                </tbody></table></td>
		            </tr>
		          </tbody></table>			
				</td>
		            </tr>
		          </tbody></table>
MSG
			ret.html_safe

	end
	
	def link_to_online_view(ass)
		kuo = ass.data_file_name.split('.')[-1]
		if 'flv'==kuo
			link_to "[在线播放]","/assets/playflv/#{ass.id}",:onclick=>"return please_buy_first(#{ass.courseware_id})"
		elsif 'wmv'==kuo
			link_to "[在线播放]","/assets/playwmv/#{ass.id}",:onclick=>"return please_buy_first(#{ass.courseware_id})"
		else
			''
		end
	end
end
