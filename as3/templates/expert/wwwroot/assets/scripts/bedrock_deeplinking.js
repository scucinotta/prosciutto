function initialize()
{
	setHashAddress( "/?" );
}

function setHashAddress( $value )
{
	window.location.hash = $value;
}
function getHashAddress()
{
	return window.location.hash;
}


function setHashPath( $value )
{
	setHashAddress( "/" + $value + "?" + getHashQuery() );
}
function getHashPath()
{
	return getHashAddress().slice( getHashAddress().lastIndexOf("/")+1, getHashAddress().lastIndexOf("?") );
}



function setHashQuery( $value )
{
	setHashAddress( "/" + getHashPath() + "?" + $value );
}
function  getHashQuery()
{
	return getHashAddress().slice( getHashAddress().lastIndexOf("?")+1, getHashAddress().length );
}





function setStatus( $value )
{
	window.status = $value;
}
function getStatus( $value )
{
	return window.status;
}


function setTitle( $value )
{
	document.title = $value;
}
function getTitle( $value )
{
	return document.title;
}