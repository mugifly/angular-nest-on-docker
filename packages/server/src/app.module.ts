import { Module } from '@nestjs/common';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ArticlesModule } from './articles/articles.module';

@Module({
  imports: [
    // Serve the Angular app (../../client/dist/client/) as a static files
    // (for production environment)
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', '..', 'client', 'dist', 'client'),
    }),
    ArticlesModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
