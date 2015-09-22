saveWinners = function( league, season, week ){
	var data = { method: 'putTrophyData', returnFormat: 'json', league : league, season : season, week : week, trophies : {} };
	$( ".stats-pod" ).each( function() {
		var myData = [];
		$( this ).find( '.winnerName' ).each( function() {
			myData.push( $( this ).html() );
		} );
		data.trophies[$( this ).find( '.trophyTitle' ).html() ] = myData ;
	});
	data.trophies = JSON.stringify( data.trophies );
	$.ajaxSetup({
		url: '/services/remote.cfc',
		dataType: 'json',
		type: 'POST'
	});

	var oPost = {
		data: data,
		success: function( result ){
			if( result.success ){
				$('#saveSuccess').removeClass( 'hide' );
				$('#saveError').addClass( 'hide' );
			}
			else{
				$('#saveSuccess').addClass( 'hide' );
				$('#saveError').removeClass( 'hide' );
			}
		}
	};
	$.ajax( oPost );
}