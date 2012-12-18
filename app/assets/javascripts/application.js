// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .



$(document).ready(function() {
	
	$("#upvotesdiv").hide();
	$(".box").hide();
	$('.ajax').css('display', 'inline')
	$('.ajax').show();
	$('#header').css("background", "#5555CC")
	$('.first').hide();
	$('.correct').hide();
	$('.conservative').hide();
	$('.liberal').hide();
	$('.mainstream').hide();
	$('.conspiracytheory').hide();
	$('.14').hide();
	$('.old_guy').hide();
	var grouptoshow = $('#qcontent #hiddengroup').text();
	if (grouptoshow !== '') {
		$('#qcontent .' + grouptoshow).show();
	}
	
	//$('.first').show();
 


	$('.commentclass').click(function() {
		var data = new Object();
		var anumberlong = $(this).attr('id');
		data.answer_id= anumberlong.replace('comment_','')
		data.text = $("#tb_" + data.answer_id).val();
		data.user_id = $("#hiddencurrentuser").text();
		data.question_id = $("#hiddenquestionid").text();
		$.ajax({
				type: "POST",
				url: '/newcomment',
				data: data,
				success: function(){
					
				},
				error: function() {}
				
				
			});
		var name = $("#hiddencurrentname").text();
		$('#commdiv_' + data.answer_id).append('<br /><div id="cdiv"><span id="commentuser">' + name + '</span><span id="commenttext">' + data.text + '</span><br /></div><br /><br />');	
		$('#cb_' + data.answer_id).hide();
		$("#tb_" + data.answer_id).val('');

	})
	
	
		
	
	$('.firstsquarebutton').click(function() {
		
		$('.first').show();
		$('.correct').hide();
		$('.conservative').hide();
		$('.liberal').hide();
		$('.mainstream').hide();
		$('.conspiracytheory').hide();
		$('.14').hide();
		$('.old_guy').hide();
		});

	$('.14squarebutton').click(function() {
		
		$('.14').show();
		$('.first').hide();
		$('.correct').hide();
		$('.conservative').hide();
		$('.liberal').hide();
		$('.mainstream').hide();
		$('.conspiracytheory').hide();
		$('.old_guy').hide();
		});	
		
	$('.old_guysquarebutton').click(function() {
		
		$('.old_guy').show();
		$('.first').hide();
		$('.correct').hide();
		$('.conservative').hide();
		$('.liberal').hide();
		$('.mainstream').hide();
		$('.conspiracytheory').hide();
		$('.14').hide();
		});	
		
	$('.conservativesquarebutton').click(function() {
		
		$('.conservative').show();
		$('.first').hide();
		$('.correct').hide();
		$('.old_guy').hide();
		$('.liberal').hide();
		$('.mainstream').hide();
		$('.conspiracytheory').hide();
		$('.14').hide();
		});	
		
	$('.liberalsquarebutton').click(function() {
		
		$('.liberal').show();
		$('.first').hide();
		$('.correct').hide();
		$('.conservative').hide();
		$('.old_gut').hide();
		$('.mainstream').hide();
		$('.conspiracytheory').hide();
		$('.14').hide();
		});	
		
	$('.mainstreamsquarebutton').click(function() {
		
		$('.mainstream').show();
		$('.first').hide();
		$('.correct').hide();
		$('.conservative').hide();
		$('.liberal').hide();
		$('.old_guy').hide();
		$('.conspiracytheory').hide();
		$('.14').hide();
		});	
		
	$('.conspiracytheorysquarebutton').click(function() {
		
		$('.conspiracy theory').show();
		$('.first').hide();
		$('.correct').hide();
		$('.conservative').hide();
		$('.liberal').hide();
		$('.mainstream').hide();
		$('.old_guy').hide();
		$('.14').hide();
		});	
		
	$('.correctsquarebutton').click(function() {
		
		$('.correct').show();
		$('.first').hide();
		$('.old_guy').hide();
		$('.conservative').hide();
		$('.liberal').hide();
		$('.mainstream').hide();
		$('.conspiracytheory').hide();
		$('.14').hide();
		});		
		
		
		
		
	$('#upvotebutton1').click(function() {
		
		
		
		if ($("#upvotebutton1").attr("src") != "/assets/upvotegreen.png") {
			$("#upvotebutton1").attr("src","/assets/upvotegreen.png");
			var userid=$('#hiddenuser').text();
			
			var old = $("#upvotesfrom").text();
			
			if (old == '') {
					newlist = $('#hiddencurrentname').text(); }
				else {
					newlist = old + ', ' + $('#hiddencurrentname').text();
		}
			
			
			$("#upvotesfrom").text(newlist); 
			$.ajax({
				type: "GET",
				url: '/upvote_user/' + userid,
						success: function(){
					
					
				
				},
				error: function() {}
				
				
			});
		}
		else   			// if button was green
		 {
			 
			var userid=$('#hiddenuser').text();
			$("#upvotebutton1").attr("src","/assets/upvote.png");
			
			
			var old = $("#upvotesfrom").text();
			var cname = $('#hiddencurrentname').text()
			var position=old.indexOf(cname); 
			
			if (position > 2) {
					var newlist = old.replace(", " + cname,"");  }
				else {
					var newlist = old.replace( cname,"");  }
			if (newlist.indexOf(',') < 2)  newlist = newlist.replace(", ","")
			
		 $('#upvotesfrom').text(newlist)
		
		$.ajax({
				type: "GET",
				url: '/downvote_user/' + userid,
						success: function(){
					
					
				
				},
				error: function() {}
				
				
			});
		 }
	});
	

	
	
	$('#qupvotebutton1').click(function() {
		
		if ($("#qupvotebutton1").attr("src") != "/assets/upvotegreen.png") {
			$("#qupvotebutton1").attr("src","/assets/upvotegreen.png");
			var questionid=$('#hiddenquestionid').text();  
			
			$('#upcount').text(parseInt($('#upcount').text()) + 1);
			
			$('#list').append('<li><a href="../users/' + $('#hiddencurrentuser').text() + '">' + $("#hiddencurrentname").text() + '</a></li>');
			
			$.ajax({
				type: "GET",
				url: '/upvote_question/' + questionid,
						success: function(){
					
				},
				error: function() {}
				
				
			});
			
		}
		else   			// if button was green
		 {
			$("#qupvotebutton1").attr("src","/assets/upvote.png");
			var questionid=$('#hiddenquestionid').text();
			
			$('#upcount').text($('#upcount').text() - 1);
			
			var counter = 0;
			var needle=1000;
			$("#list li").each(function() {				
				var t = $(this);
				if (t.text() == $('#hiddencurrentname').text() ) {
					needle = counter;							 	
				}
				counter++;				
			})
			$("#list li:eq(" + needle + ")").remove();
				
			$.ajax({
				type: "GET",
				url: '/downvote_question/' + questionid,
						success: function(){
					
				},
				error: function() {}
							
			});
		 }
	})
	
	$('.aupvotebutton').click(function() {
		
		if ($(this).attr("src") == "/assets/upvote.png") {
			$(this).attr("src","/assets/upvotegreen.png");
			var answerid = $(this).attr("id");
			
			$("#aid_" + answerid).text(parseInt($("#aid_" + answerid).text()) + 1);
			$('#list_' + answerid).append('<li><a href="../users/' + $('#hiddencurrentuser').text() + '">' + $("#hiddencurrentname").text() + '</a></li>');
			
			
			$.ajax({
				type: "GET",
				url: '/upvote_answer/' + answerid,
						success: function(){
					
				},
				error: function() {}
				
				
			});
			
			
		}
		else {
			$(this).attr("src","/assets/upvote.png");
			var answerid = $(this).attr("id");
			
			$("#aid_" + answerid).text(parseInt($("#aid_" + answerid).text()) - 1);
			
			var counter = 0;
			var needle=1000;
			$("#list_" + answerid + " li").each(function() {				
				var t = $(this);
				if (t.text() == $('#hiddencurrentname').text() ) {
					needle = counter;							 	
				}
				counter++;				
			})
			
			$("#list_" + answerid + " li:eq(" + needle + ")").remove();
			
			
			$.ajax({
				type: "GET",
				url: '/downvote_answer/' + answerid,
						success: function(){
					
				},
				error: function() {}
				
				
			});
			
			
		}
	})
	
	$('#qshowbutton').click(function() {
		if ($("#qshowbutton").attr("src") == "/assets/show.png") {
			$("#qshowbutton").attr("src","/assets/hide.png");
			$("#upvotesdiv").show();
		}
		else
		{
			$("#qshowbutton").attr("src","/assets/show.png");
			$("#upvotesdiv").hide();
		}
		
	})
	
	$('.ashowbutton').click(function() {
		aid = $(this).attr("id");
		
		if ($(this).attr("src") == "/assets/show.png") {
			$(this).attr("src","/assets/hide.png");
			$("#aiddiv_" + aid).show();
		}
		else
		{
			$(this).attr("src","/assets/show.png");
			$("#aiddiv_" + aid).hide();
		}
		
	})
})
