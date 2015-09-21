<cfparam name="attributes.title" >
<cfparam name="attributes.method" />
<cfparam name="attributes.teams" default="#[]#" />
<cfparam name="attributes.trophyData" default="#{}#" />
<cfset prevWinner = [] />
<cfif structKeyExists( attributes.trophyData, attributes.title )>
	<cfset prevWinner = attributes.trophyData[ attributes.title ] />
</cfif>

<cfoutput>
	<div class="team-pod stats-pod col-md-3 ">
		<h4 class="trophyTitle">#attributes.title#</h4>
		<table class="table  table-condensed">
		
		<cfif arrayLen( attributes.teams )>
			<cfset count = 1 />
			<cfset winner = true />
			<cfset first =  -9999999999 />
			<cfloop array="#attributes.teams#" index="team" >
				
				<cfif arrayFind( prevWinner, team.getTeamName() )EQ 1>
					<cfset winner = false />
					<cfset count-- />
				<cfelse>
					<cfset first = first EQ -9999999999 ? evaluate("team.#attributes.method#") : first  />
					<cfset winner = count EQ 1 OR count GT 1 AND first EQ evaluate("team.#attributes.method#")  ? true : false />
				</cfif>
				<tr <cfif winner>class="success"</cfif>>
					<td>
						<cfif winner>
							<i class="glyphicon glyphicon-star"></i>
						</cfif>
					</td>
					<td <cfif winner>class="winnerName"</cfif>>#team.getTeamName()#</td>
					<td >#numberFormat( evaluate("team.#attributes.method#"), '999.00' )#</td>
				</tr>
				<cfset count++ />
			</cfloop>
		<cfelse>
		<tr><td>None</td></tr>
		</cfif>
		</table>
	</div>
</cfoutput>

<cfexit method="exittag" />