import { Component, OnInit } from '@angular/core';
import { DefaultService, CreateArticleDto } from 'src/.api-client';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent implements OnInit {
  title = 'client';
  articles = {};
  numOfArticles = 0;

  constructor(private api: DefaultService) {}

  async ngOnInit() {
    await this.getArticles();
  }

  async getArticles() {
    // Get the articles from the backend (WebAPI)
    this.articles = await this.api.articlesControllerFindAll().toPromise();
    this.numOfArticles = Object.keys(this.articles).length;
  }

  async addArticle() {
    // Add the article
    let article: CreateArticleDto = {
      title: 'Example',
      description: `This article was created at ${new Date().toString()}.`,
    };
    await this.api.articlesControllerCreate(article).toPromise();
    // Refresh
    this.getArticles();
  }
}
