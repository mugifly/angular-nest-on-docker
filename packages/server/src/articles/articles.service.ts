import { Injectable } from '@nestjs/common';
import { CreateArticleDto } from './dto/create-article.dto';
import { UpdateArticleDto } from './dto/update-article.dto';

@Injectable()
export class ArticlesService {
  private articles: any;
  private lastId: number;

  constructor() {
    this.articles = {
      1: {
        title: 'Example',
        description: 'this is example article',
      },
    };
    this.lastId = 1;
  }

  create(createArticleDto: CreateArticleDto) {
    this.lastId++;
    this.articles[this.lastId] = createArticleDto;
  }

  findAll() {
    return this.articles;
  }

  findOne(id: number) {
    return this.articles[id];
  }

  update(id: number, updateArticleDto: UpdateArticleDto) {
    this.articles[id] = updateArticleDto;
  }

  remove(id: number) {
    delete this.articles[id];
  }
}
