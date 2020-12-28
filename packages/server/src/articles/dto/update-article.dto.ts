import { PartialType } from '@nestjs/mapped-types';
import { CreateArticleDto } from './create-article.dto';
import { ApiProperty } from '@nestjs/swagger';

export class UpdateArticleDto extends PartialType(CreateArticleDto) {
  @ApiProperty({
    description: 'Title',
    type: String,
  })
  title: string;

  @ApiProperty({
    description: 'Description',
    type: String,
  })
  description: string;
}
