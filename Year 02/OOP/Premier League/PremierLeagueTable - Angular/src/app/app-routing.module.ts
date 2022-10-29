import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ClubStatsComponent } from './club-stats/club-stats.component';
import { MatchDetailsComponent } from './match-details/match-details.component';

const routes: Routes = [

  { path: '', component: ClubStatsComponent },
  { path: 'matchDetails', component: MatchDetailsComponent },
  { path: '**', redirectTo: '' }

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})

export class AppRoutingModule {}