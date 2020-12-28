import { ApiProperty } from '@nestjs/swagger';

export class CreateArticleDto {
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
