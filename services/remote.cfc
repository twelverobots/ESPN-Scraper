component {
	
	remote function putTrophyData( required league, required season, required week, required trophies={} ){
		try{
			if( !directoryExists( expandPath( '/data' ) ) ){
				directoryCreate( expandPath( '/data' ) );
			}
			if( !directoryExists( expandPath( '/data/' & league ) ) ){
				directoryCreate( expandPath( '/data/' & league ) );
			}
			if( !directoryExists( expandPath( '/data/' & league & '/' & season) ) ){
				directoryCreate( expandPath( '/data/' & league & '/' & season ) );
			}
			if (!fileExists( expandPath( '/data/' & league & '/' & season & '/trophies.json')  ) ){
				fileWrite( expandPath( '/data/' & league & '/' & season & '/trophies.json'), serializeJson( {} ) );
			}
			var fileData = fileRead( expandPath( '/data/' & league & '/' & season & '/trophies.json') );
			var data = deserializeJSON( fileData );
			data[ week ] = deserializeJSON( trophies );
			fileWrite( expandPath( '/data/' & league & '/' & season & '/trophies.json'), serializeJson( data ) );
			return { 'success' : true, 'data' : data };
		}
		catch( any e){
			return { 'success' : false };
		}
	}
}