import { NestFactory } from '@nestjs/core';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Change the URL prefix to `/api` on backend
  app.setGlobalPrefix('api');

  // Build the OpenAPI document (published under `/api/docs`) with Swagger
  const doc_options = new DocumentBuilder().setTitle(`API Document`).build();
  const doc = SwaggerModule.createDocument(app, doc_options);
  SwaggerModule.setup('api/docs', app, doc);

  // Start the server
  await app.listen(3000);
}
bootstrap();
