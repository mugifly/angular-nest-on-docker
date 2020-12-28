import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { HttpClientModule } from '@angular/common/http';
import { ApiModule, Configuration } from '../.api-client';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

@NgModule({
  declarations: [AppComponent],
  imports: [
    BrowserModule,
    AppRoutingModule,

    // API client
    HttpClientModule,
    ApiModule.forRoot(
      () =>
        new Configuration({
          basePath: '',
        }),
    ),
  ],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
