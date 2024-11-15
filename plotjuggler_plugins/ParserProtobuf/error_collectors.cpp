#include "error_collectors.h"
#include <QMessageBox>
#include <QDebug>

void FileErrorCollector::AddError(const std::string& filename, int line, int,
                                  const std::string& message)
{
  auto msg = QString("File: [%1] Line: [%2] Message: %3\n\n")
                 .arg(QString::fromStdString(filename))
                 .arg(line)
                 .arg(QString::fromStdString(message));

  _errors.push_back(msg);
}

void FileErrorCollector::AddWarning(const std::string& filename, int line, int,
                                    const std::string& message)
{
  auto msg = QString("Warning [%1] line %2: %3")
                 .arg(QString::fromStdString(filename))
                 .arg(line)
                 .arg(QString::fromStdString(message));
  qDebug() << msg;
}

void FileErrorCollector::RecordError(absl::string_view filename, int line, int column,
                                     absl::string_view message)
{
  QString errorMessage = QString("Error in file: %1 at line: %2, column: %3: %4")
                             .arg(QString::fromStdString(std::string(filename)))
                             .arg(line)
                             .arg(column)
                             .arg(QString::fromStdString(std::string(message)));
  _errors << errorMessage;
}
void IoErrorCollector::AddError(int line, google::protobuf::io::ColumnNumber,
                                const std::string& message)
{
  _errors.push_back(
      QString("Line: [%1] Message: %2\n").arg(line).arg(QString::fromStdString(message)));
}

void IoErrorCollector::AddWarning(int line, google::protobuf::io::ColumnNumber column,
                                  const std::string& message)
{
  qDebug() << QString("Line: [%1] Message: %2\n")
                  .arg(line)
                  .arg(QString::fromStdString(message));
}
