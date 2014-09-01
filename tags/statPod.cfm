<cfparam name="attributes.title" >
<cfparam name="attributes.method" />
<cfparam name="attributes.teams" default="#[]#" />


<cfoutput>
	<div class="team-pod col-md-3 col-md-offset-1">
		<h4>#attributes.title#</h4>
		<table class="table table-striped table-hover table-condensed">
		<cfif arrayLen( attributes.teams )>
			<cfloop array="#attributes.teams#" index="team" >
				<tr><td>#team.getTeamName()#</td><td>#evaluate("team.#attributes.method#")#</td></tr>
			</cfloop>
		<cfelse>
		<tr><td>None</td></tr>
		</cfif>
		</table>
	</div>
</cfoutput>

<cfexit method="exittag" />