<cfparam name="attributes.title" >
<cfparam name="attributes.method" />
<cfparam name="attributes.teams" default="#[]#" />
<cfparam name="attributes.trophyData" default="#{}#" />
<cfparam name="attributes.trackPrevious" default="true" />
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
				
				<cfif attributes.trackPrevious AND arrayFind( prevWinner, team.getTeamId() )EQ 1>
					<cfset winner = false />
					<cfset count-- />
				<cfelse>
					<cfset first = first EQ -9999999999 ? evaluate("team.#attributes.method#") : first  />
					<cfset winner = count EQ 1 OR count GT 1 AND first EQ evaluate("team.#attributes.method#")  ? true : false />
				</cfif>
				<tr <cfif winner OR !attributes.trackPrevious>class="success"</cfif> >
					<td>
						<cfif winner OR !attributes.trackPrevious>
							<i class="glyphicon glyphicon-star"></i>
						</cfif>
					</td>
					<td <cfif winner OR !attributes.trackPrevious>class="winnerName" data-teamId="#team.getTeamId()#"</cfif>>#team.getTeamName()#</td>
					<td class="text-right">#numberFormat( evaluate("team.#attributes.method#"), '999.00' )#</td>
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