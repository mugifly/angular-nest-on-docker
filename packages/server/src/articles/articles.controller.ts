import { Controller, Get, Post, Body, Put, Param, Delete } from '@nestjs/common';
import { ArticlesService } from './articles.service';
import { CreateArticleDto } from './dto/create-article.dto';
import { UpdateArticleDto } from './dto/update-article.dto';
import { ApiOperation } from '@nestjs/swagger';

@Controller('articles')
export class ArticlesController {
  constructor(private readonly articleService: ArticlesService) {}

  @Post()
  @ApiOperation({ summary: 'Create an article' })
  create(@Body() createArticleDto: CreateArticleDto) {
    return this.articleService.create(createArticleDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get the all articles' })
  findAll() {
    return this.articleService.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get the specified article' })
  findOne(@Param('id') id: string) {
    return this.articleService.findOne(+id);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update the specified article' })
  update(@Param('id') id: string, @Body() updateArticleDto: UpdateArticleDto) {
    return this.articleService.update(+id, updateArticleDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete the specified article' })
  remove(@Param('id') id: string) {
    return this.articleService.remove(+id);
  }
}
