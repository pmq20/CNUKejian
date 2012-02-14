



<!DOCTYPE html>
<% pos = "#{controller.controller_name}::#{controller.action_name}" %>
<html>
<head>
	<title>CNU课件交流系统 - <%= pos %></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%= stylesheet_link_tag 'default' %>
	<%= javascript_include_tag '/javascripts/jquery.min.js' %>
	<%= javascript_include_tag '/javascripts/rails.js' %>
	<%= javascript_include_tag '/javascripts/application.js' %>
	<%= javascript_include_tag '/jwplayer/jwplayer.js'%>
	<%= csrf_meta_tag %>
	<script>
		<% if 'metawelcome::faq'==pos %>
			parent.window.document.title = "CNU课件交流系统 - FAQ"
		<% elsif 'metawelcome::team'==pos %>
			parent.window.document.title = "CNU课件交流系统 - 开发团队"
		<% end %>

	</script>
	<script>
		if(0==parent.frames.length){
			window.location.href = '/?main='+'<%=j request.request_uri%>'
		}
	</script>
</head>
<body>

	<%=render :partial=>'layouts/shared/common_act'%>
	
	
	<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
				<tbody><tr>
				   <td class="Linetop"></td>
				</tr>
	</tbody></table>
	<table class="title" id="tblHead" width="100%" border="0" cellpadding="0" cellspacing="0">
		<tbody><tr>
			<td>
				<table align="left" border="0" cellpadding="0" cellspacing="0">					
				<tbody><tr>
				<td>&nbsp;</td>
				<td valign="middle" id="yemian_title"><b>
				<% if pos=='welcome::show_yonghu' or pos=='cpan::profile' %>
				  [ <a href="javascript:history.go(-1)">返回上一页</a> ]
				<% else %>
					<script type="text/javascript" charset="utf-8">
						document.write(parent.window.document.title.split('-')[1])
					</script>
					<%=' - 上传' if 'coursewares::new'==pos or 'coursewares::create'==pos%>
					<% if controller.controller_name=='metawelcome' %> [ <a href="javascript:history.go(-1)">返回上一页</a> ]<%end%>
				<% end %>
				</b></td>
				</tr>
				</tbody></table>
			</td>				
		</tr>		
	</tbody></table>
	<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
		<tbody><tr>
			<td class="Linetop"></td>
		</tr>
	</tbody></table>


<% if alert %>
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
						<strong><font color="#990000"><%= alert.html_safe %></font></strong><br>
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
<% end %>


<% if defined?(resource) and resource and !resource.errors.empty? %>
	<%= give_alert(resource.errors.full_messages.join('<br />')) %>
<% end %>

<% if defined?(@resource) and @resource and !@resource.errors.empty? %>
	<%= give_alert(@resource.errors.full_messages.join('<br />')) %>
<% end %>


<% if notice %>
<table width="100%" cellspacing="0" cellpadding="0" border="0" style="">
              <tbody><tr> 
                <td valign="top"> 
				
<table width="100%" cellspacing="0" cellpadding="0" border="0" style=" border: 5px solid #FFF;">
			     <tbody><tr> 
			       <td valign="top">
				<table width="100%" cellspacing="0" cellpadding="0" border="0" class="errorLine">
                    <tbody><tr> 
                      <td height="5" colspan="4"></td>
                    </tr>
                    <tr>
                      <td width="5">&nbsp;</td> 
                      <td width="32" valign="top"><img width="32" height="32" src="/images/icon/tip2.gif"></td>
                      <td width="5">&nbsp;</td>
                      <td valign="top">
                      <table width="100%" cellspacing="0" cellpadding="0" border="0">
						<tbody><tr>
						<td class="errorTop">
						<%= notice.html_safe %><br>
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
<% end %>


	<%= yield %>
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fd0ae935da2b640b2daf33fbe071c4c2f' type='text/javascript'%3E%3C/script%3E"));
</script>
	
</body>
</html>

