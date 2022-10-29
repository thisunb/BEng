import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ClubStatsComponent } from './club-stats.component';

describe('ClubStatsComponent', () => {
  let component: ClubStatsComponent;
  let fixture: ComponentFixture<ClubStatsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ClubStatsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ClubStatsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
